import { Kind } from '../enums/Kind';
import { Component } from './Component';

class VerticalSeparator extends Component {
  constructor(parameters: VerticalSeparator = {} as VerticalSeparator) {
    // @ts-expect-error
    parameters = { kind: Kind.VerticalSeparator, ...parameters };

    super(parameters);
  }
};

export { VerticalSeparator };