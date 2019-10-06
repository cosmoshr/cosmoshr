export default class Component extends HTMLElement {
  constructor(html) {
    super()
    const shadowDOM = this.attachShadow({ mode: 'closed' })

    const container = document.createElement('div')
    container.innerHTML = html

    shadowDOM.appendChild(container)
  }
}
