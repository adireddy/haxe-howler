/**
 * Created by Adi Mora on 25/04/2015.
 */
module.exports = function (grunt) {

    grunt.initConfig({
        pkg: grunt.file.readJSON("package.json"),

        haxe: {
            project: {
                hxml: "build.hxml"
            }
        },

        zip: {
            "howler.zip": ["howler/**", "haxelib.json"]
        },

        copy: {
            default: {
                files: [
                    {expand: true, cwd: "samples/_output/", src: ["**"], dest: "../adireddy.github.io/demos/haxe-howler/"},
                ]
            }
        }
    });

    grunt.loadNpmTasks("grunt-haxe");
    grunt.loadNpmTasks("grunt-zip");
    grunt.loadNpmTasks("grunt-exec");
    grunt.loadNpmTasks("grunt-npm-install");
    grunt.loadNpmTasks("grunt-contrib-copy");
    grunt.registerTask("default", ["haxe", "copy"]);
};