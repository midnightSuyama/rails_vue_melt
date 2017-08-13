<template>
  <div>
    <p>{{ message }}</p>
  </div>
</template>

<script>
export default {
  data: () => ({
    message: 'Hello Vue!'
  })
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
