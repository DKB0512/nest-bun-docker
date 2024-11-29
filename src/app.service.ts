import { Injectable } from '@nestjs/common';

@Injectable()
export class AppService {
  constructor() {}

  getBun(): string {
    return 'Hello From Nest-Bun';
  }
}
