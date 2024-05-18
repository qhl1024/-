<script setup lang="ts">
import useUserStore from "@/store/modules/user.ts";
import ShowRecords from "@/components/showRecords/index.vue"
let userStore = useUserStore();

</script>

<template>
  <ShowRecords :id="userStore.token" :show="false" ></ShowRecords>
</template>

<style scoped>
</style>