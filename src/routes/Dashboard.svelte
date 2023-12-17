<script lang="ts">
  import CreateProposal from '../components/CreateProposal.svelte';
  import SeeProposal from '../components/SeeProposal.svelte';
  import Vote from '../components/Vote.svelte';
  import Members from '../components/Members.svelte';
  import { canisterId } from '../declarations/backend/index.js';
  export let view = '';

  function changeView(text: string) {
    view = text;
  }
</script>

<div class="wrapper">
  <div class="sidebar">
    <div on:click={() => changeView('create-proposal')}>Create proposal ✏️</div>
    <div on:click={() => changeView('see-proposal')}>See proposals 👀</div>
    <div on:click={() => changeView('vote')}>Vote 🗳️</div>

    <button> <a href="https://li2te-6qaaa-aaaaj-qa3ga-cai.raw.icp0.io/" target="_blank" > Manifesto 📜 </a> </button>
  </div>

  <div class="main-view">
    <h1>Dashboard</h1>

    {#if view === 'create-proposal'}
      <CreateProposal />
    {/if}

    {#if view === 'see-proposal'}
      <SeeProposal />
    {/if}

    {#if view === 'vote'}
      <Vote />
    {/if}


    {#if view === ''}
      <h2>Choose an option from the sidebar</h2>
    {/if}
  </div>
</div>

<style>
  .wrapper {
    display: flex;
    flex-direction: row;
  }

  .main-view {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    height: 100vh;
    width: 80%;
    background-color: red;
  }
  .sidebar {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    height: 100vh;
    width: 20%;
    background-color: blue;
  }

  .sidebar div {
    margin: 10px;
    cursor: pointer;
  }

  .sidebar button {
    margin: 10px;
    cursor: pointer;
  }
</style>
