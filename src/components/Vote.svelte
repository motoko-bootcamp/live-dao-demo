<script lang="ts">
  import { get } from 'svelte/store';
  import { actor } from '../stores/auth.store';

  let proposalId: number = 0;

  const handleVote = async (vote: boolean) => {
    const actorInstance = get(actor);
    try {
      let result = await actorInstance.vote(BigInt(proposalId), vote);
      console.log(result);
    } catch (e) {
      console.error(e);
    }
  };
</script>

<div>
  <h1>Vote</h1>
  <input
    type="number"
    placeholder="Indicate proposal Id"
    bind:value={proposalId}
  />
  <button on:click={() => handleVote(true)}>Yes</button>
  <button on:click={() => handleVote(false)}>No</button>
</div>
