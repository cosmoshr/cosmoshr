import bus from '../lib/bus'

document.onkeydown = key => {
  bus.emit('keydown', key)
}

bus.on('start-game', () => {
  bus.emit('hide_splash')
})
