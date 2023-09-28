import { Kind } from '../enums/Kind';
import { Component } from './Component';

class Box extends Component {
  constructor(parameters: Box = {} as Box) {
    // @ts-expect-error
    parameters = { kind: Kind.Box, ...parameters };

    super(parameters);

    // @ts-expect-error
    const component = globalThis[this.id];

    component.properties.onPress = this.onPress;
    component.properties.onRelease = this.onRelease;
    component.properties.motionNotify = this.motionNotify;
    component.properties.focusChange = this.focusChange;
    component.properties.onKeyPress = this.onKeyPress;
  }

  destroyChildren = () => {
    // @ts-expect-error
    const component = globalThis[this.id];

    component.destroyChildren();
  };
};

export { Box };