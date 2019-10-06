import Component from '../component'
import html from '../html'

class RoundedButton extends Component {
  constructor() {
    super(html`
      <button><slot></slot></button>
      <style>
        div {
          transition-duration: 0.2s;
          display: block;

          width: calc(100% - 20px);
          height: 50px;

          padding: 10px;
          margin-bottom: 20px;

          background-color: #ffffff80;
          border-radius: 1000000px;
        }

        div:hover {
          opacity: 0.9;
        }
        button {
          font-size: 20px;
          display: block;
          width: 100%;
          height: 100%;
          border: none;
          border-radius: 1000000px;
          cursor: pointer;
        }
      </style>`)
  }
}

customElements.define('rounded-button', RoundedButton)
