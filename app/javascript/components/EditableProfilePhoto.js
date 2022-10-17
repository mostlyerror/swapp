import React, { Component } from 'react'
import Webcam from "react-webcam"

class EditableProfilePhoto extends Component {
  constructor(props) {
    super(props)
    this.openCamera = this.openCamera.bind(this)
  }

  videoConstraints = {
    facingMode: "environment"
  };

  state = {
    capturedImageSrc: null,
    editing: this.props.editing,
    camera: false,
  }

  openCamera(evt) {
    evt.preventDefault()
    this.setState({
      camera: true,
    })
  }

  render() {
    if (this.state.camera) {
      return <Webcam
        audio={false}
        height={720}
        screenshotFormat="image/jpeg"
        width={1280}
        videoConstraints={this.videoConstraints}
      >
        {({ getScreenshot }) => (
          <button
            className="px-4 md:px-6 py-1 md:py-2 bg-white focus:outline-none focus:ring-2 focus:ring-offset-2 text-gray-700 focus:ring-indigo-500 hover:bg-gray-50 rounded shadow border"
            onClick={(evt) => {
              evt.preventDefault()
              const imageSrc = getScreenshot()
              this.setState({
                capturedImageSrc: imageSrc,
                camera: false,
              })
              const $el = document.getElementById(this.props.element_id)
              $el.setAttribute('value', imageSrc)
            }}
          >
            Capture photo
          </button>
        )}
      </Webcam>
    }

    return (
      <div className="flex">
        <img src={this.state.capturedImageSrc || this.props.default_image_source} className="h-32" />
        { this.state.editing && <button className="px-4 md:px-6 py-1 md:py-2 bg-white focus:outline-none focus:ring-2 focus:ring-offset-2 text-gray-700 focus:ring-indigo-500 hover:bg-gray-50 rounded shadow border" onClick={this.openCamera}>Take photo</button> }
      </div>
    )
  }
}

export default EditableProfilePhoto