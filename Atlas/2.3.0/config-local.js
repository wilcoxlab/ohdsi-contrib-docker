define([], function () {
  var configLocal = {};

  configLocal.api = {
      name: '${ORGNAME}',
      url: '${WEBAPIURL}'
  };

  return configLocal;
});
