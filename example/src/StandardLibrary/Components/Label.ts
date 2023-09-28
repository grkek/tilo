import { Kind } from '../enums/Kind';
import { Component } from './Component';

class Label extends Component {
  constructor(parameters: Label = {} as Label) {
    // @ts-expect-error
    parameters = { kind: Kind.Label, ...parameters };

    super(parameters);

    // @ts-expect-error
    const component = globalThis[this.id];

    component.properties.onPress = this.onPress;
    component.properties.onRelease = this.onRelease;
    component.properties.motionNotify = this.motionNotify;
    component.properties.focusChange = this.focusChange;
    component.properties.onKeyPress = this.onKeyPress;
  }

  setText(text: string): string {
    // @ts-expect-error
    const component = globalThis[this.id];

    return component.setText(text);
  }

  getText(): string {
    // @ts-expect-error
    const component = globalThis[this.id];

    return component.state.text;
  }
};

export { Label };