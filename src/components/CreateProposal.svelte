<script lang="ts">
  import { actor } from '../stores/auth.store';
  import { get } from 'svelte/store';

  let manifesto: string = '';

  const handleCreateProposal = async () => {
    const proposal = manifesto;
    let result = await get(actor).createProposal(proposal);
    console.log(result);
  };
</script>

<div class="main">
  <h2>Create proposal</h2>
  <p>Create a proposal to be voted on by the members of the DAO</p>

  <div>Your proposal</div>
  <input type="text" placeholder="Enter your proposal" bind:value={manifesto} />
  <button on:click={() => handleCreateProposal()}>Create proposal</button>
</div>

<style>
  .main {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    height: 100vh;
  }
</style>
