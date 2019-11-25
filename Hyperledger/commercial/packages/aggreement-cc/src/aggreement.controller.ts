import * as yup from 'yup'; 
import { ChaincodeTx } from '@worldsibu/convector-platform-fabric';
import {
  Controller,
  ConvectorController,
  Invokable,
  Param
} from '@worldsibu/convector-core';

import { Aggreement } from './aggreement.model';

// This controller is going to be run inside of  acontainer which is linked to 
// a node/peer, and it's through the low-level communication which changes the ledger.

@Controller('aggreement')
export class AggreementController extends ConvectorController<ChaincodeTx> {
  @Invokable()
  public async create(
    @Param(Aggreement)
    aggreement: Aggreement
  ) { 
    await aggreement.save(); 
  }

  // A Function which checks whether both parties agree. 
  @Invokable()
  public async whatIsTheStatus( 
    @Param(yup.string())  // yup is a library which validates datatypes. 
    id: string 
  ) {
    const aggreement = await Aggreement.getOne(id); 
    if(aggreement.agreeParty1 && aggreement.agreeParty2){
      return 'agreed.'; 
    }

    if(!aggreement.agreeParty1 || !aggreement.agreeParty2){
      return 'not agreed'; 
    } 
  } 

  // First, we check who's sending the tx. 
  // Multiple parties participate in the same ledger with the same rules, 
  // and anybody can try to create/change in the data of a smart contract 
  // Therefore we have to blind the source code with the logic that validates 
  // that the people who make the transaction, are allowed to do it. 
  @Invokable()
  public async sign(
    @Param(yup.string()) 
    id: string, 
    @Param(yup.boolean()) 
    response: boolean

  ) {
      const aggreement = await Aggreement.getOne(id);
      if(aggreement.party1 === this.sender){
        aggreement.agreeParty1 = response;
      } 

      if(aggreement.party2 === this.sender){
        aggreement.agreeParty2 = response;
      }

      await aggreement.save(); 

  }
}


