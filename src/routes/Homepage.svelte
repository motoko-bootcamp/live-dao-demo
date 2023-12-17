<script lang="ts">

    const handleLogin = () => {
        console.log("Login button clicked")
    };
</script>

<div>
  <h1>Welcome to Motoko Bootcamp DAO</h1>
  <p>Click on login to join the adventure</p>
  <button on:click|preventDefault={() => handleLogin()}>Login </button>
</div>
