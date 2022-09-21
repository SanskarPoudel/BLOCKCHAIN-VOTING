const EVoting = artifacts.require("evoting");

module.exports = function (deployer) {
    deployer.deploy(
        EVoting,
        "Sanskar",
        "Paudel",
        "poudelsanskar@gmail.com",
        931113000000,
        "9866010209",
        "12345678900"
    );
};
