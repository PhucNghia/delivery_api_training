import * as testUtils from '@vue/test-utils'
import Auth from './Auth.vue'
import axios from 'axios'
const HOST = 'http://localhost:3000'

jest.mock('axios', () => ({
  get: jest.fn(),
  post: jest.fn((is_resolve) => {
    if (is_resolve) {
      return Promise.resolve({
        user: {},
        token: ""
      })
    } else {
      return Promise.reject({
        response: {
          data: { message: "Error" }
        }
      })
    }
  })
}))

var cmp;

beforeEach(() => {
  cmp = testUtils.shallowMount(Auth);
  jest.resetModules();
  jest.clearAllMocks();
})

describe('Structure', () => {
  describe('button submit', () => {
    it('is sign in when state.signup false', () => {
      cmp.setData({
        state: { sign_up: false }
      });
      const button = cmp.find('button[type=submit]');
      expect(button.text()).toBe('Sign In');
    })

    it('is sign up when state.signup true', () => {
      cmp.setData({
        state: { sign_up: true }
      });
      const button = cmp.find('button[type=submit]');
      expect(button.text()).toBe('Sign Up');
    })

    it('call method sign_in when click and state.signup false', () => {
      cmp.setData({
        state: { sign_up: false }
      });
      const button = cmp.find('button[type=submit]');
      const spy = jest.spyOn(cmp.vm, 'sign_in');

      button.trigger('click');
      expect(spy).toHaveBeenCalled();
    })

    it('call method sign_up when click and state.signup true', () => {
      cmp.setData({
        state: { sign_up: true }
      });
      const button = cmp.find('button[type=submit]');
      const spy = jest.spyOn(cmp.vm, 'sign_up');

      button.trigger('click');
      expect(spy).toHaveBeenCalled();
    })
  })

  describe('alert', () => {
    it('message when has error', () => {
      cmp.setData({
        error: {
          message: 'Error'
        }
      })

      let div_alert = cmp.find('div.alert');
      expect(div_alert.exists()).toBe(true);
      expect(div_alert.text()).toBe('Error')
    })
  })
})

describe('Methods', () => {
  let username = 'username' + (new Date()).getTime();
  describe('sign_up', () => {
    it('axios post has error when invalid user', () => {
      cmp.vm.sign_up();
      expect.assertions(1);
      return axios.post(false).catch(e => {
        expect(cmp.vm.error).not.toBeUndefined()
      })
    })

    it('axios post resolve when valid user', () => {
      cmp.vm.sign_up();
      return axios.post(true).then(data => {
        expect(data).not.toBeUndefined();
        expect(cmp.emitted('sign_in').length).toBe(1)
      })
    })
  })

  describe('sign_in', () => {
    it('axios post resolve when valid user', () => {
      cmp.vm.sign_in();
      return axios.post(true).then(data => {
        expect(data).not.toBeUndefined();
        expect(cmp.emitted('sign_in').length).toBe(1)
      })
    })
  })

  describe('clear_input', () => {
    it('clear input text', () => {
      cmp.setData({
        user: {
          username: username,
          password: '123123',
          password_confirmation: '123123'
        }
      })
      let input_username = cmp.find('input[type=text]').attributes('value');

      cmp.vm.clear_input();

      expect(input_username).toBe('')
    })
  })
})
