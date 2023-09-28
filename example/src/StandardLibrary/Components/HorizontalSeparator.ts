import { Kind } from '../enums/Kind';
import { Component } from './Component';

class HorizontalSeparator extends Component {
  constructor(parameters: HorizontalSeparator = {} as HorizontalSeparator) {
    // @ts-expect-error
    parameters = { kind: Kind.HorizontalSeparator, ...parameters };

    super(parameters);
  }
};

export { HorizontalSeparator };