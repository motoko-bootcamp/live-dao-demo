<script lang="ts">
  import './App.css';
  import { Router, Link, Route } from 'svelte-routing';
  import Home from './routes/Homepage.svelte';
  import CreateUser from './routes/CreateUser.svelte';
  import Dashboard from './routes/Dashboard.svelte';

  export let url = '';
</script>

<Router {url}>
  <div>
    <Route path="/create-user"><CreateUser /></Route>
    <Route path="/dashboard"><Dashboard /></Route>
    <Route path="/"><Home /></Route>
  </div>
</Router>
