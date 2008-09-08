# manifests/packages/idn.pp

class php::packages::idn {
    php::pecl{'idn': }
}
