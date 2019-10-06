import html from './html.html'
import './style.scss'
import page from '../page'
import bus from '../../lib/bus'

const el = page(html)
let prev = 'home'

const click = (item, data) => {
  switch (item) {
    case 'change_screen':
      el.querySelector('#splash_back').className = 'slidein'
      el.querySelector('#splash_home').className = 'page'
      el.querySelector(`#splash_${data}`).className = 'fadein page'
      prev = data
      break
    case 'back':
      el.querySelector(`#splash_${prev}`).className = 'page'
      el.querySelector('#splash_home').className = 'fadein page'
      el.querySelector('#splash_back').className = 'slideout'
      break
    default:
      break
  }
}

bus.on('splash_click', click.bind(this))
bus.on('hide_splash', () => {
  el.hidden = true
  el.innerHTML = html
})
bus.on('show_splash', () => {
  this.el.hidden = false
})
