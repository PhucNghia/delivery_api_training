<template>
  <div id="Auth">
    <div class="form" v-if="has_error">
      <div class="alert alert-warning" role="alert">
        {{ error.message }}
      </div>
    </div>
    <div class="form">
      <form>
        <div class="form-group">
          <input type="text" class="form-control" placeholder="Enter Username" autofocus v-model="user.username" value="">
        </div>
        <div class="form-group">
          <input type="password" class="form-control" placeholder="Password" v-model="user.password">
        </div>
        <div class="form-group" v-show="state.sign_up">
          <input type="password" class="form-control" placeholder="Password confirmation" v-model="user.password_confirmation">
        </div>
        <div>
          <button
            type="submit"
            class="btn btn-primary"
            v-if="state.sign_up"
            @click.prevent="sign_up"
          >Sign Up</button>
          <button type="submit" class="btn btn-primary" v-else @click.prevent="sign_in">Sign In</button>
        </div>
      </form>
    </div>
    <div class="sub">
      <a @click.prevent="state.sign_up = false">Sign In</a>
      <a @click.prevent="state.sign_up = true">Sign Up</a>
    </div>
  </div>
</template>

<script>
const HOST = "http://localhost:3000";
import axios from "axios";

export default {
  name: "Auth",
  data: function() {
    return {
      error: {},
      state: {
        sign_up: false
      },
      user: {
        username: "",
        password: "",
        password_confirmation: ""
      }
    };
  },
  computed: {
    has_error() {
      return Object.keys(this.error).length > 0
    },

    this_sign_up() {
      return this.state.sign_up;
    }
  },
  watch: {
    this_sign_up() {
      this.user.password_confirmation = "";
    }
  },
  methods: {
    sign_up() {
      axios
        .post(HOST + "/sign_up", this.user)
        .then(res => {
          this.$emit("sign_in", res.data);
          this.clear_input();
        })
        .catch(error => {
          this.error = error.response.data;
        });
    },

    sign_in() {
      axios
        .post(HOST + "/sign_in", this.user)
        .then(res => {
          this.$emit("sign_in", res.data);
          this.clear_input();
        })
        .catch(error => {
          this.error = error.response.data;
        });
    },

    clear_input() {
      this.user = {
        username: "",
        password: "",
        password_confirmation: ""
      };
    }
  }
};
</script>

<style lang="scss" scoped>
#Auth {
  min-height: 100vh;
  width: 100%;
  .form {
    width: 25%;
    min-width: 320px;
    background: white;
    margin: 100px auto 0;
    padding: 2rem;
    border-radius: 0.5rem;
    box-shadow: 1px 1px 5px rgba(0, 0, 0, 0.3);
  }
  .sub {
    width: 25%;
    min-width: 320px;
    padding-left: 2rem;
    margin: 1rem auto;
    a {
      padding-right: 1rem;
      color: white;
      &:hover {
        text-decoration: underline;
        cursor: pointer;
      }
    }
  }
}
</style>
