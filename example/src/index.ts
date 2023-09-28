import * as UserInterface from './StandardLibrary/UserInterface';

import config from './config';

import { Chat } from './Components/Body/Chat';
import { Entry } from './StandardLibrary/Components/Entry';

import { Request } from './StandardLibrary/Http';
import { Button } from './StandardLibrary/Components/Button';
import { Image } from './StandardLibrary/Components/Image';

console.log("Finished rendering the UI...");

const crystalLogo = UserInterface.getComponent('crystalLogo') as Image;

crystalLogo.setResourcePath(`${(globalThis as any)['contentDirectory']}/images/logo.png`);

const joinButton = UserInterface.getComponent('joinButton', { onPress: () => {
  const usernameEntry = UserInterface.getComponent("usernameEntry") as Entry;
  const username = usernameEntry.getText();

  const request = new Request(`${config.apiUrl}/users/${username}`);
  const response = request.get();

  if (response.statusCode === 200) {
    joinButton
      .parent
      .parent
      .destroyChildren();

    const { body: { chatId } } = response.body;

    new Chat({
      username: username,
      chatId: chatId,
      parent: joinButton.parent.parent
    } as Chat)
  } else {
    console.error(`Received an invalid response code ${response.statusCode}`)
  }
}} as Button);