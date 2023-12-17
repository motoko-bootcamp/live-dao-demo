<script lang="ts">
  import { onMount } from 'svelte';
  import { actor } from '../stores/auth.store';
  import { get } from 'svelte/store';
  import { navigate } from 'svelte-routing';


  let name = '';
  let age : number = 0;

  const handleSubmission = async () => {
    const actorInstance = get(actor)
    try {
        let member = {
            name: name,
            age: BigInt(age)
        };
        let result = await actorInstance.addMember(member);

        navigate('/dashboard');
    } catch (e) {
      console.error(e);
    }
  };
</script>

<h1>Create user</h1>
<form>
  <label for="name">Name</label>
  <input
    type="text"
    id="name"
    name="name"
    bind:value={name}
    placeholder="Your name.."
  />

  <label for="email">Age</label>
  <input
    type="text"
    id="age"
    name="age"
    bind:value={age}
    placeholder="Your age.."
  />

  <button on:click|preventDefault={() => handleSubmission()}>Register</button>
</form>
