import { config } from './app/app-config-server'; 
import { bootstrapApplication, BootstrapContext } from '@angular/platform-browser';
import { App } from './app/app';
import { provideZoneChangeDetection } from '@angular/core';

const bootstrap = (context: BootstrapContext) => bootstrapApplication(App, {...config, providers: [provideZoneChangeDetection(), ...config.providers]}, context);

export default bootstrap;