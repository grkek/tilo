import { Kind } from '../enums/Kind';
import { Component } from './Component';

class ListBox extends Component {
  constructor(parameters: ListBox = {} as ListBox) {
    // @ts-expect-error
    parameters = { kind: Kind.ListBox, ...parameters };

    super(parameters);

    // @ts-expect-error
    const component = globalThis[this.id];

    component.properties.onPress = this.onPress;
    component.properties.onRelease = this.onRelease;
    component.properties.motionNotify = this.motionNotify;
    component.properties.focusChange = this.focusChange;
    component.properties.onKeyPress = this.onKeyPress;
  }

  removeAll() {
    // @ts-expect-error
    const component = globalThis[this.id];

    component.removeAll();
  }
};

export { ListBox };