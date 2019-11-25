import * as yup from 'yup';
import {
  ConvectorModel,
  Default,
  ReadOnly,
  Required,
  Validate
} from '@worldsibu/convector-core-model';

export class Aggreement extends ConvectorModel<Aggreement> {
  @ReadOnly()
  @Required()
  public readonly type = 'io.worldsibu.aggreement';

  @Required()
  @Validate(yup.string())
  public name: string;

  @Required()
  @ReadOnly()
  public title: string;

  
  @Required()
  @ReadOnly()
  public description: string;

  @Required() 
  @ReadOnly() 
  public party1: string;

  @Required() 
  @ReadOnly()
  public party2: string; 

  public agreeParty1: boolean;
  public agreeParty2: boolean; 

  @Required() 
  public finishDate: Date; 
 
  @ReadOnly()
  @Required()
  @Validate(yup.number()) 
  public created: number;

  @Required()
  @Validate(yup.number())
  public modified: number;
}
