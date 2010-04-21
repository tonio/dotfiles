#!/usr/bin/env php
<?php

foreach (new DirectoryIterator('./') as $item) {
  if (
    in_array($item, array('.git', 'install.php')) ||
    $item->isDot() ||
    preg_match('/\.sw(p|o)$/', $item->getFileName())
  ) continue;
  
  $src = dirname(__FILE__).'/'.$item;
  $dst = '~/'.$item;
  `rm -ri $dst`;
  `ln -s $src $dst`;
}
