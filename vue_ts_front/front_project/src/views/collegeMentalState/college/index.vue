<script setup lang="ts">
import {ref} from "vue";
import useUserStore from "@/store/modules/user.ts";
import ScaleOutcome from "@/components/scaleOutcome/index.vue"

let userStore = useUserStore();
let token = ref('');
token.value = userStore.token
</script>

<template>
  <ScaleOutcome :id="token"></ScaleOutcome>
</template>

<style scoped>

</style>