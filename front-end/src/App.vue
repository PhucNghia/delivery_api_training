<template>
  <div id="app">
    <div v-if="is_sign_in">
      <Orders></Orders>
    </div>
    <div v-else>
      <Auth @sign_in="sign_in"></Auth>
    </div>
  </div>
</template>

<script>
import Orders from "./components/Orders.vue";
import Auth from "./components/Auth.vue";

export default {
  name: "app",
  data: function() {
    return {
      user: {},
      token: "",
    };
  },
  computed: {
    is_sign_in() {
      return this.token.length > 0 ? true : false;
    }
  },
  components: {
    Orders,
    Auth
  },
  methods: {
    sign_in(data) {
      this.user = data.user;
      this.token = data.token;
    }
  }
};
</script>

<style lang="scss">
@import "../node_modules/bootstrap/scss/bootstrap.scss";

body {
  background-image: linear-gradient(
    to right bottom,
    #051937,
    #004a7b,
    #0081a0,
    #00b993,
    #12eb54
  );
  min-height: 100vh;
  width: 100%;
}
</style>
