/* eslint-disable max-classes-per-file */
import {
  Application, Sprite, Container, Texture
} from 'pixi.js'
import hex from './hex.svg'
import spacePort from './SpacePort.svg'
import soldier from './Soldier.svg'
import bus from './lib/bus'

const viewport = new Application({
  width: innerWidth,
  height: innerHeight
})

viewport.view.id = 'app'
document.body.appendChild(viewport.view)


// const bg = new Graphics()
// bg.beginFill(0x555555)
// bg.drawRect(0, 0, 100, 100)
// bg.endFill()
// viewport.stage.addChild(bg)

const scale = 1

class Hex extends Sprite {
  constructor(x, y, unique) {
    super(Texture.from(hex))

    this.x = x * scale
    this.y = y * scale
    this.width = 100 * scale
    this.height = 100 * scale

    this.id = [unique.unique, unique.index]

    bus.on('hex', (id, task, data) => {
      if (id[0] === this.id[0] && id[1] === this.id[1]) switch (task) {
        case 'change_texture':
          this.texture = Texture.from(data)
          break
        default:
          break
      }
    })
  }
}

class Row extends Container {
  constructor(y, indent, unique) {
    super()
    for (let index = 0; index < 5; index++) this.addChild(new Hex(index * 95 + indent, y, { unique, index }))
  }
}

class Grid extends Container {
  constructor() {
    super()
    for (let index = 0; index < 5; index++) this.addChild(new Row(index * 75, (index % 2 === 0) ? 0 : 50, index))
  }
}

viewport.stage.addChild(new Grid())

const map = [
  [soldier, hex, hex, hex, soldier],
  [hex, hex, hex, hex, hex],
  [hex, hex, spacePort, hex, hex],
  [hex, hex, hex, hex, hex],
  [soldier, hex, hex, hex, soldier]
]

map.forEach((thing, index) => {
  thing.forEach((texture, _index) => {
    bus.emit('hex', [index, _index], 'change_texture', texture)    
  })
})
