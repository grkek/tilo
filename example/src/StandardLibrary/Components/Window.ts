import { Kind } from '../enums/Kind';
import { Component } from './Component';

class Window extends Component {
  constructor(parameters: Window = {} as Window) {
    // @ts-expect-error
    parameters = { kind: Kind.Window, ...parameters };

    super(parameters);

    // @ts-expect-error
    const component = globalThis[this.id];

    component.properties.onPress = this.onPress;
    component.properties.onRelease = this.onRelease;
    component.properties.motionNotify = this.motionNotify;
    component.properties.focusChange = this.focusChange;
    component.properties.onKeyPress = this.onKeyPress;
  }
};

export { Window };