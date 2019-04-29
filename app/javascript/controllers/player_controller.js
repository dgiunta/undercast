import { Controller } from "stimulus"

const SPACE = 32;

export default class extends Controller {
  static targets = ['audio', 'playbackSpeed']

  initialize() {
    this.playbackSpeed = window.playbackSpeed;
    this.isPlaying = false
    this.start();
  }

  togglePlay(e) {
    if (e.type.match(/key(?=down|up)/)) {
      if (e.keyCode != SPACE) {
        return
      }
    }

    e.preventDefault();
    this.isPlaying ?  this.pause() : this.play();
  }

  start() {
    this.audioTarget.addEventListener("canplaythrough", this.play);
  }

  play() {
    if (this.audioTarget) {
      this.isPlaying = true;
      this.audioTarget.play()
    }
  }

  pause() {
    if (this.audioTarget) {
      this.isPlaying = false;
      this.audioTarget.pause();
    }
  }

  changeSpeed() {
    this.playbackSpeed = this.playbackSpeedFormValue;
  }

  set isPlaying(value) {
    this.data.set("isPlaying", value);
  }

  get isPlaying() {
    return this.data.get("isPlaying") == "true";
  }

  set playbackSpeed(speed) {
    speed = speed || '1.0'
    window.playbackSpeed = speed
    this.playbackSpeedTarget.value = speed;
    this.audioTarget.playbackRate = parseFloat(speed, 10);
  }

  get playbackSpeedFormValue() {
    return this.playbackSpeedTarget.value;
  }
}
