<?php

require_once __DIR__.'/../vendor/autoload.php';

$site = new \Skimpy\Site(__DIR__);

$app = $site->bootstrap();

$app->register(\Skimpy\Lumen\Providers\SkimpyRouteProvider::class);

return $app->run();

