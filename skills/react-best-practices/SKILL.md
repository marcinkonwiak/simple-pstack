---
name: react-best-practices
description: React best practices. Use when reading or editing any react file.
---

# React best practices

Most of these rules are about `useEffect`. An effect syncs React with a system outside React. Before you write one, check that a rule below does not already cover the case.

| Rule | Summary |
|------|---------|
| Derive, do not sync | Compute a value from props or state during render. Do not copy it into `useState` and update it in an effect. |
| Handlers, not effects | Do the work in the event handler that caused it. Do not set a flag so that an effect can act on it. |
| Fetch with the data layer | Load data with the route loader or the query library of the repository. Do not `fetch` in an effect and store the result in state. |
| One owner for async state | Take loading, error, and data from one query. Separate `useState` calls for each can disagree. |
| Reset with `key` | To start fresh when an id changes, give the component a `key`. Do not reset state in an effect. |
| Mount when ready | Render the component only when its preconditions hold. Do not guard inside the effect. |
| Effects are for external systems | Keep an effect that syncs with the DOM, a browser API, storage, or a third-party widget. Give it a cleanup. |
| Browser state after mount | With server rendering, read `localStorage` or `window` in an effect or `useSyncExternalStore`. A `useState` initializer causes a hydration mismatch. |


## useEffect usage

Do not completely ban `useEffect`, a correct effect is better than a bad replacement.

Before you write an effect, ask what causes the code to run.

- A user action causes it. Put the code in the event handler.
- A change in props or state causes it, and the result is a value. Compute the value during render.
- Data from a server causes it. Use the route loader or the query library.
- The component appears on screen, or an external system changes. Write the effect.

An effect is wrong when it does one of these:

- It sets state that you can compute from props or other state.
- It reacts to a flag that an event handler set.
- It fetches data and stores the result in state.
- It resets state when a prop changes.
- It triggers another effect through state.

Every correct effect has a cleanup when it subscribes, starts a timer, or creates something. Its dependency array lists every value it reads.

## Examples

```tsx
// Don't. Two renders, and the copy can go stale.
const [visible, setVisible] = useState<Item[]>([]);
useEffect(() => setVisible(items.filter((i) => i.inStock)), [items]);

// Do.
const visible = items.filter((i) => i.inStock);
```

```tsx
// Don't. The effect hides the click that caused the write.
useEffect(() => {
	localStorage.setItem(key, JSON.stringify(hidden));
}, [hidden, key]);

// Do. Write where the change happens.
function onHiddenChange(next: string[]) {
	setHidden(next);
	localStorage.setItem(key, JSON.stringify(next));
}
```

```tsx
// Don't. Three states that can disagree, and no cancellation.
useEffect(() => {
	if (open) void loadSessions();
}, [open, loadSessions]);

// Do.
const sessions = useQuery({
	queryKey: ["sessions"],
	queryFn: listSessions,
	enabled: open,
});
```

```tsx
// Do. A browser listener is an external system. Keep the effect.
useEffect(() => {
	document.addEventListener("keydown", onKeyDown);
	return () => document.removeEventListener("keydown", onKeyDown);
}, []);
```
