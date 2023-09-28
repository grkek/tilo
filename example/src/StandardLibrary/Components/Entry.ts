import { Kind } from '../enums/Kind';
import { Component } from './Component';

class Entry extends Component {
  constructor(parameters: Entry = {} as Entry) {
    // @ts-expect-error
    parameters = { kind: Kind.Entry, ...parameters };

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

    return component.getText();
  }
};

export { Entry };