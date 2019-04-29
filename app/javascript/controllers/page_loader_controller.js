import {Controller} from 'stimulus';

const SCROLL_OFFSET = 100;

export default class extends Controller {
  initialize() {
    this.data.set('loading', false);
    this.data.set('initialized', true);
    this.loadMore();
  }

  loadMore() {
    if (this.shouldLoad && this.isWithinRange) {
      this.data.set('loading', 'true')
      let evt = new MouseEvent('click', {
        view: window,
        bubbles: true,
        cancelable: true
      });
      this.element.dispatchEvent(evt);
    }
  }

  get shouldLoad() {
    return this.data.get('initialized') == 'true' &&
      this.data.get('loading') != 'true'
  }

  get isWithinRange() {
    let bottomOfWindow = window.scrollY + window.innerHeight;
    let topOfTrigger = this.element.offsetTop

    return bottomOfWindow >= (topOfTrigger - SCROLL_OFFSET);
  }
}
