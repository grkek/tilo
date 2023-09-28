import { Kind } from '../enums/Kind';
import { Component } from './Component';

class Image extends Component {
  constructor(parameters: Image = {} as Image) {
    // @ts-expect-error
    parameters = { kind: Kind.Image, ...parameters };

    super(parameters);

    // @ts-expect-error
    const component = globalThis[this.id];

    component.properties.onPress = this.onPress;
    component.properties.onRelease = this.onRelease;
    component.properties.motionNotify = this.motionNotify;
    component.properties.focusChange = this.focusChange;
    component.properties.onKeyPress = this.onKeyPress;
  }

  setResourcePath(path: string): string {
    // @ts-expect-error
    const component = globalThis[this.id];

    return component.setResourcePath(path);
  }

  getResourcePath(): string {
    // @ts-expect-error
    const component = globalThis[this.id];

    return component.state.resourcePath;
  }
};

export { Image };