import { Kind } from "../enums/Kind";
import { Align } from "../enums/Align";
import { Orientation } from "../enums/Orientation";

class Component {
  id: string;
  className: string;
  kind: Kind;

  containerLabel: string;
  containerExpand: boolean;
  containerFill: boolean;
  containerPadding: number;

  horizontalAlignment: Align;
  verticalAlignment: Align;
  orientation: Orientation = Orientation.Vertical;

  nativeWidget: any;
  parent: Component;

  onPress = () => { };
  onRelease = () => { };
  onKeyPress = (keyValue: number) => { };

  focusChange = () => { };
  motionNotify = () => { };

  destroyChildren = () => { };

  constructor(parameters: Component = {} as Component) {
    //@ts-expect-error
    const randomId = Cryptography__MD5(Cryptography__UUID4());

    this.id = parameters.id ? parameters.id.replace(/[0-9]/g, '') : randomId.replace(/[0-9]/g, '');
    this.kind = parameters.kind;
    this.className = parameters.className ? parameters.className : '';

    this.parent = parameters.parent;
    this.nativeWidget = parameters.nativeWidget ? parameters.nativeWidget : undefined;

    /*
      Event handlers
    */

    this.onPress = parameters.onPress
      ? parameters.onPress : this.onPress;

    this.onRelease = parameters.onRelease
      ? parameters.onRelease : this.onRelease;

    this.motionNotify = parameters.motionNotify
      ? parameters.motionNotify : this.motionNotify;

    this.focusChange = parameters.focusChange
      ? parameters.focusChange : this.focusChange;

    this.onKeyPress = parameters.onKeyPress
      ? parameters.onKeyPress : this.onKeyPress;

    /*
      Container attributes
    */

    this.containerLabel = parameters.containerLabel
      ? parameters.containerLabel : 'Untitled';

    this.containerExpand = parameters.containerExpand
      ? parameters.containerExpand : false;

    this.containerFill = parameters.containerFill
      ? parameters.containerFill : false;

    this.containerPadding = parameters.containerPadding
      ? parameters.containerPadding : 0;

    /*
      Base attributes
    */

    this.horizontalAlignment = parameters.horizontalAlignment
      ? parameters.horizontalAlignment : Align.Baseline;

    this.verticalAlignment = parameters.verticalAlignment
      ? parameters.verticalAlignment : Align.Baseline;

    switch (parameters.orientation) {
      case 0:
        this.orientation = Orientation.Horizontal;
        break;
      case 1:
        this.orientation = Orientation.Vertical;
      case undefined:
        break;
      default:
        break;
    }

    switch (parameters.kind) {
      case Kind.Label:
        if (this.nativeWidget === undefined) {
          // @ts-expect-error
          const widget = UserInterface__Label(
            this.id,
            this.className,
            parameters.parent.nativeWidget,
            this.containerLabel,
            this.containerExpand,
            this.containerFill,
            this.containerPadding,
            this.horizontalAlignment,
            this.verticalAlignment,
            this.orientation
          );

          this.nativeWidget = widget;
        }
        break;
      case Kind.Box:
        if (this.nativeWidget === undefined) {
          // @ts-expect-error
          const widget = UserInterface__Box(
            this.id,
            this.className,
            parameters.parent.nativeWidget,
            this.containerLabel,
            this.containerExpand,
            this.containerFill,
            this.containerPadding,
            this.horizontalAlignment,
            this.verticalAlignment,
            this.orientation
          );

          this.nativeWidget = widget;
        }
        break;
      case Kind.Button:
        if (this.nativeWidget === undefined) {
          // @ts-expect-error
          const widget = UserInterface__Button(
            this.id,
            this.className,
            parameters.parent.nativeWidget,
            this.containerLabel,
            this.containerExpand,
            this.containerFill,
            this.containerPadding,
            this.horizontalAlignment,
            this.verticalAlignment,
            this.orientation
          );

          this.nativeWidget = widget;
        }
        break;
      case Kind.Entry:
        if (this.nativeWidget === undefined) {
          // @ts-expect-error
          const widget = UserInterface__Entry(
            this.id,
            this.className,
            parameters.parent.nativeWidget,
            this.containerLabel,
            this.containerExpand,
            this.containerFill,
            this.containerPadding,
            this.horizontalAlignment,
            this.verticalAlignment,
            this.orientation
          );

          this.nativeWidget = widget;
        }
        break;
      case Kind.Image:
        if (this.nativeWidget === undefined) {
          // @ts-expect-error
          const widget = UserInterface__Image(
            this.id,
            this.className,
            parameters.parent.nativeWidget,
            this.containerLabel,
            this.containerExpand,
            this.containerFill,
            this.containerPadding,
            this.horizontalAlignment,
            this.verticalAlignment,
            this.orientation
          );

          this.nativeWidget = widget;
        }
        break;
      case Kind.ListBox:
        if (this.nativeWidget === undefined) {
          // @ts-expect-error
          const widget = UserInterface__ListBox(
            this.id,
            this.className,
            parameters.parent.nativeWidget,
            this.containerLabel,
            this.containerExpand,
            this.containerFill,
            this.containerPadding,
            this.horizontalAlignment,
            this.verticalAlignment,
            this.orientation
          );

          this.nativeWidget = widget;
        }
        break;
      case Kind.ScrolledWindow:
        if (this.nativeWidget === undefined) {
          // @ts-expect-error
          const widget = UserInterface__ScrolledWindow(
            this.id,
            this.className,
            parameters.parent.nativeWidget,
            this.containerLabel,
            this.containerExpand,
            this.containerFill,
            this.containerPadding,
            this.horizontalAlignment,
            this.verticalAlignment,
            this.orientation
          );

          this.nativeWidget = widget;
        }
        break;
      case Kind.HorizontalSeparator:
        if (this.nativeWidget === undefined) {
          // @ts-expect-error
          const widget = UserInterface__HorizontalSeparator(
            this.id,
            this.className,
            parameters.parent.nativeWidget
          );

          this.nativeWidget = widget;
        }

        break;
      case Kind.VerticalSeparator:
        if (this.nativeWidget === undefined) {
          // @ts-expect-error
          const widget = UserInterface__VerticalSeparator(
            this.id,
            this.className,
            parameters.parent.nativeWidget
          );

          this.nativeWidget = widget;
        }

        break;
      case Kind.Window:
        // @ts-expect-error
        const widget = UserInterface__GetMainWindow()
        this.nativeWidget = widget;

        break;
    }
  }
};

export { Component };