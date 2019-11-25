// tslint:disable:no-unused-expression
import { join } from 'path';
import { expect } from 'chai';
import * as uuid from 'uuid/v4';
import { MockControllerAdapter } from '@worldsibu/convector-adapter-mock';
import { ClientFactory, ConvectorControllerClient } from '@worldsibu/convector-core';
import 'mocha';

import { Kickstarter, KickstarterController } from '../src';

describe('Kickstarter', () => {
  let adapter: MockControllerAdapter;
  let kickstarterCtrl: ConvectorControllerClient<KickstarterController>;
  
  before(async () => {
    // Mocks the blockchain execution environment
    adapter = new MockControllerAdapter();
    kickstarterCtrl = ClientFactory(KickstarterController, adapter);

    await adapter.init([
      {
        version: '*',
        controller: 'KickstarterController',
        name: join(__dirname, '..')
      }
    ]);

    adapter.addUser('Test');
  });
  
  it('should create a default model', async () => {
    const modelSample = new Kickstarter({
      id: uuid(),
      name: 'Test',
      created: Date.now(),
      modified: Date.now()
    });

    await kickstarterCtrl.$withUser('Test').create(modelSample);
  
    const justSavedModel = await adapter.getById<Kickstarter>(modelSample.id);
  
    expect(justSavedModel.id).to.exist;
  });
});