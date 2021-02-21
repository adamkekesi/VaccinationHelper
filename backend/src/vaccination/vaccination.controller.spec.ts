import { Test, TestingModule } from '@nestjs/testing';
import { VaccinationController } from './vaccination.controller';

describe('VaccinationController', () => {
  let controller: VaccinationController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [VaccinationController],
    }).compile();

    controller = module.get<VaccinationController>(VaccinationController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
