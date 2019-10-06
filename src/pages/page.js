export default html => {
  const el = document.createElement('div')
  el.innerHTML = html
  document.body.appendChild(el)
  return el
}
