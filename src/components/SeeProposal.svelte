<script lang="ts">
  import { get } from 'svelte/store';
  import { actor } from '../stores/auth.store';
  import { onMount } from 'svelte';
  import type { Proposal, Status } from '../declarations/backend/backend.did';

  let proposals: Proposal[] = [];

  onMount(async () => {
    const actorInstance = get(actor);
    try {
      proposals = await actorInstance.getAllProposals();
    } catch (e) {
      console.error(e);
    }
  });

  const handleRefresh = async () => {
    const actorInstance = get(actor);
    try {
      proposals = await actorInstance.getAllProposals();
    } catch (e) {
      console.error(e);
    }
  };

  function statusToString(s: Status) {
    if (s.hasOwnProperty('Open')) {
      return 'Open';
    } else if (s.hasOwnProperty('Rejected')) {
      return 'Rejected';
    } else {
      return 'Accepted';
    }
  }
</script>

<div>
  <h1>See proposals</h1>
  <p>See all the proposals that have been created</p>
  <button on:click|preventDefault={() => handleRefresh()}>Refresh</button>

  {#each proposals as proposal}
    <div>
      <p>Created by: {proposal.creator}</p>
      <p>Status : {statusToString(proposal.status)}</p>
      <p>Manifesto: {proposal.manifesto}</p>
      <p>Id: {proposal.id}</p>
    </div>
  {/each}
</div>
