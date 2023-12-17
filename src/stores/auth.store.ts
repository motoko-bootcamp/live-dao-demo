import { writable } from "svelte/store";
import type { _SERVICE } from "../declarations/backend/backend.did";


export const actor = writable<_SERVICE>();

