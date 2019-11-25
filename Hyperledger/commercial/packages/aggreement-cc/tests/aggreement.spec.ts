// tslint:disable:no-unused-expression
import { join } from 'path';
import { expect } from 'chai';
import * as uuid from 'uuid/v4';
import { MockControllerAdapter } from '@worldsibu/convector-adapter-mock';
import { ClientFactory, ConvectorControllerClient } from '@worldsibu/convector-core';
import 'mocha';

import { Aggreement, AggreementController } from '../src';

describe('Aggreement', () => {
  let adapter: MockControllerAdapter;
  let aggreementCtrl: ConvectorControllerClient<AggreementController>;
  
  before(async () => {
    // Mocks the blockchain execution environment
    adapter = new MockControllerAdapter();
    aggreementCtrl = ClientFactory(AggreementController, adapter);

    await adapter.init([
      {
        version: '*',
        controller: 'AggreementController',
        name: join(__dirname, '..')
      }
    ]);

    adapter.addUser('Test');
  });
  
  it('should create a default model', async () => {
    const modelSample = new Aggreement({
      id: uuid(),
      name: 'Test',
      created: Date.now(),
      modified: Date.now()
    });

    await aggreementCtrl.$withUser('Test').create(modelSample);
  
    const justSavedModel = await adapter.getById<Aggreement>(modelSample.id);
  
    expect(justSavedModel.id).to.exist;
  });
});