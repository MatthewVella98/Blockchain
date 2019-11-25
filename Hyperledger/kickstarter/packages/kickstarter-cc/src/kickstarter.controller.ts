import { ChaincodeTx, Manager } from '@worldsibu/convector-platform-fabric';
import {
  Controller,
  ConvectorController,
  Invokable,
  Param
} from '@worldsibu/convector-core';

import { Kickstarter } from './kickstarter.model';

@Controller('kickstarter')
export class KickstarterController extends ConvectorController<ChaincodeTx> {
  @Invokable()
  public async create(
    @Param(Kickstarter)
    kickstarter: Kickstarter
  ) { 
    await kickstarter.save();
    this.sender = kickstarter.manager; 
  }

  @Invokable()
  public async enter(

  ) {
    const senderTx = await Kickstarter.getOne(this.sender); 
    if(senderTx != Kickstarter.manager){

    }

  }

  @Invokable()
  public async createRequest(
    @Param(yup.string()) 
    description: string,
    @Param(yup.number()) 
    value: number,
    @Param(yup.string())
    recipient: string){

    }

  @Invokable()
  public async approveRequest(index: number) {
    const kickstarter = await Kickstarter.getOne(this.sender); 
    kickstarter.Request
  }

  @Invokable()
    public async finalizeRequest(index: number) {
      const kickstarter = await Kickstarter.getOne(this.sender); 
      kickstarter.
    }
  }
