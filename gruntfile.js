/**
 * Created by Adi Mora on 10/10/2014.
 */

module.exports = function (grunt) {

    grunt.initConfig({
        pkg: grunt.file.readJSON("package.json"),

        zip: {
            "howler.zip": ["howler/**", "haxelib.json"]
        }
    });

    grunt.loadNpmTasks("grunt-zip");
    grunt.registerTask("default", ["zip"]);
};