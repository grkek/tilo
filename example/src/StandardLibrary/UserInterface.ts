import { Label } from './Components/Label';
import { Box } from './Components/Box';
import { Window } from './Components/Window';
import { Button } from './Components/Button';
import { Entry } from './Components/Entry';
import { Image } from './Components/Image';
import { Component } from './Components/Component';


const getComponent = (id: string, properties: Component = {} as Component) : Component => {
  // @ts-expect-error
  const component = globalThis[id];

  switch(component.state.kind){
    case 'LABEL':
      return new Label({
        //@ts-expect-error
        id: id,
        //@ts-expect-error
        className: component.state.className,
        //@ts-expect-error
        nativeWidget: UserInterface__GetWidget(id),
        //@ts-expect-error
        parent: getComponent(UserInterface__GetWidgetParent(id)),
        ...properties
      } as Label);
    case 'BOX':
      return new Box({
        //@ts-expect-error
        id: id,
        //@ts-expect-error
        className: component.state.className,
        // @ts-expect-error
        nativeWidget: UserInterface__GetWidget(id),
        // @ts-expect-error
        parent: getComponent(UserInterface__GetWidgetParent(id)),
        ...properties
      } as Box);
    case 'BUTTON':
      return new Button({
        //@ts-expect-error
        id: id,
        //@ts-expect-error
        className: component.state.className,
        //@ts-expect-error
        nativeWidget: UserInterface__GetWidget(id),
        //@ts-expect-error
        parent: getComponent(UserInterface__GetWidgetParent(id)),
        ...properties
      } as Button);
    case 'ENTRY':
      return new Entry({
        //@ts-expect-error
        id: id,
        //@ts-expect-error
        className: component.state.className,
        //@ts-expect-error
        nativeWidget: UserInterface__GetWidget(id),
        //@ts-expect-error
        parent: getComponent(UserInterface__GetWidgetParent(id)),
        ...properties
      } as Entry);
    case 'IMAGE':
      return new Image({
        //@ts-expect-error
        id: id,
        //@ts-expect-error
        className: component.state.className,
        //@ts-expect-error
        nativeWidget: UserInterface__GetWidget(id),
        //@ts-expect-error
        parent: getComponent(UserInterface__GetWidgetParent(id)),
        ...properties
      } as Image)
    case 'WINDOW':
      return new Window({
        //@ts-expect-error
        id: id,
        //@ts-expect-error
        className: component.state.className,
        //@ts-expect-error
        nativeWidget: UserInterface__GetWidget(id),
        ...properties
      } as Window);
    default:
      console.log("I ERRORED OUT!!!")
      throw `${component.state.kind} is not supported`;
  };
};

export { getComponent };