<!DOCTYPE html>
<!-- 
 file upload see https://github.com/thetutlage/vue-clip
 -->
<template id="qd-fileupload">
  <vue-clip :options="options">
    <template slot="clip-uploader-action">
      <div>
        <div class="dz-message"><h2> Click or Drag and Drop files here upload </h2></div>
      </div>
    </template>

    <template slot="clip-uploader-body" scope="props">
      <div v-for="file in props.files">
        <img v-bind:src="file.dataUrl" />
        {{ file.name }} {{ file.status }}
      </div>
    </template>

  </vue-clip>
</template>

<script>{
    data () {
      return {
        options: {
          url: '/vue-poc/api/upload',
          paramName: 'file',
          maxFilesize: {
            limit: 1,
            message: '{{ filesize }} is greater than the {{ maxFilesize }}'
          },
          maxFiles: {
            limit: 5,
            message: 'You can only upload a max of 5 files'
          }
        }
      }
    }

  }
</script>
