import { Component } from '../../StandardLibrary/Components/Component';

import { Box } from '../../StandardLibrary/Components/Box';
import { Label } from '../../StandardLibrary/Components/Label';
import { Orientation } from '../../StandardLibrary/enums/Orientation';
import { ListBox } from '../../StandardLibrary/Components/ListBox';
import { Entry } from '../../StandardLibrary/Components/Entry';
import { Button } from '../../StandardLibrary/Components/Button';
import { Align } from '../../StandardLibrary/enums/Align';
import { ScrolledWindow } from '../../StandardLibrary/Components/ScrolledWindow';
import { Request } from '../../StandardLibrary/Http';
import config from '../../config';

class Chat extends Component {
  username: string;
  chatId: string;

  fetchMessages() {
    const listMessages = new Request(`${config.apiUrl}/users/messages`)
    const response = listMessages.get();

    const { body: messages } = response.body;

    return messages;
  }

  updateMessages(listBox : ListBox) {
    const messages = this.fetchMessages();
    listBox.removeAll();

    messages.forEach(function (message: any) {
      const label = new Label({
        parent: listBox as Component
      } as Label);

      label.setText(`${message.username}: ${message.text}`)
    });
  }

  constructor(parameters: Chat = {} as Chat) {
    super({ ...parameters } as Chat);

    this.username = parameters.username;
    this.chatId = parameters.chatId;

    const chatContainer = new Box({ ...parameters });

    const headerContainer = new Box({
      orientation: Orientation.Vertical,
      parent: chatContainer,
      containerExpand: true
    } as Box);

    const bodyContainer = new Box({
      parent: chatContainer,
      containerExpand: true,
    } as Box);

    const usernameLabel = new Label({
      parent: headerContainer
    } as Label);

    const chatIdLabel = new Label({
      parent: headerContainer
    } as Label);

    const listBox = new ListBox({
      parent: bodyContainer,
      className: "chatListBox",
      containerExpand: true
    } as ListBox);

    const controlContainer = new Box({
      parent: bodyContainer,
      containerExpand: true,
    } as Box);

    const textEntry = new Entry({
      parent: controlContainer,
      verticalAlignment: Align.Fill,
      containerExpand: true,
      className: 'chatTextEntry'
    } as Entry);

    const buttonContainer = new Box({
      parent: controlContainer,
      orientation: Orientation.Horizontal
    } as Box)

    const sendButton = new Button({
      parent: buttonContainer,
      horizontalAlignment: Align.End,
      containerExpand: true,
      className: 'chatSendButton',
      onPress: () => {
        const createMessage = new Request(`${config.apiUrl}/users/message`)
        const messageCreated = createMessage.post({ username: this.username, text: textEntry.getText() })

        if (messageCreated.statusCode == 200) {
          this.updateMessages(listBox);
        }
      }
    } as Button);

    const refreshButton = new Button({
      parent: buttonContainer,
      horizontalAlignment: Align.Start,
      containerExpand: true,
      className: 'chatRefreshButton',
      onPress: () => {
        this.updateMessages(listBox);
      }
    } as Button);

    usernameLabel.setText(`Welcome, ${this.username}!`);
    chatIdLabel.setText(`Chat ID: ${this.chatId}`);

    sendButton.setText('Send');
    refreshButton.setText('Refresh');

    this.updateMessages(listBox);
  }
};

export { Chat };