import bus from '../lib/bus'

bus.on('quit', () => {
  history.back()
  location = 'https://web.tabliss.io'
})
