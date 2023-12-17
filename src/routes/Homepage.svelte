<script lang="ts">
  import { AuthClient } from '@dfinity/auth-client';
  import { navigate } from 'svelte-routing';
  import { Actor, HttpAgent } from '@dfinity/agent';
  import { idlFactory, canisterId } from '../declarations/backend/index';
  import { actor } from '../stores/auth.store';

  let identity = null;

  const handleLogin = async () => {
    const authClient = await AuthClient.create();
    authClient.login({
      // 7 days in nanoseconds
      maxTimeToLive: BigInt(7 * 24 * 60 * 60 * 1000 * 1000 * 1000),
      onSuccess: async () => {
        const identity = await authClient.getIdentity();
        const agent = new HttpAgent({
          identity,
        });
        if (process.env.DFX_NETWORK !== 'ic') {
          agent.fetchRootKey().catch((err) => {
            console.warn(
              'Unable to fetch root key. Check to ensure that your local replica is running',
            );
            console.error(err);
          });
        }

        actor.set(
          Actor.createActor(idlFactory, {
            agent,
            canisterId,
          }),
        );
        navigate('/create-user');
      },
      identityProvider: import.meta.env.PROD
        ? 'https://identity.ic0.app/#authorize'
        : `http://localhost:4943/?canisterId=${process.env.CANISTER_ID_INTERNET_IDENTITY}`,
    });
  };
</script>

<div>
  <h1>Welcome to Motoko Bootcamp DAO</h1>
  <p>Click on login to join the adventure</p>
  <button on:click|preventDefault={() => handleLogin()}>Login </button>
</div>
