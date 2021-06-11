import React, { useState } from 'react'

const IncidentList = (props) => {
  return (
    <div className="max-w-lg mx-auto container p-2 md:p-6 text-lg text-gray-800">
      <h3 className="py-2 font-bold tracking-wide">Incidents</h3>
      <div>
        <div className="flex gap-4 items-start">
          <div className="pt-2 max-w-xs bg-white flex items-center text-sm md:text-base rounded-full focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
            <span className="inline-flex items-center justify-center h-10 w-10 rounded-full bg-gray-500">
              <span className="text-sm md:text-base font-medium leading-none text-white">
                BP
              </span>
            </span>
          </div>
          <div className="">
            <p>
              <span className="font-semibold">Reported By:</span>{' '}
              frontdesk@comfortinn.com
            </p>
            <p className="mt-1">
              <span className="font-semibold">Date of Incident:</span> 4/10/21
            </p>
            <p className="mt-3 text-xl leading-relaxed">
              Got into an argument with hotel staff and would not keep noise
              level down. Got into an argument with hotel staff and would not
              keep noise level down.
            </p>
          </div>
        </div>
      </div>
    </div>
  )
}

const Incidents = (props) => {
  const [formIsShowing, setFormIsShowing] = useState(false)

  return (
    <div>
      <div>
        <IncidentList />
      </div>

      <div className="max-w-lg mx-auto container p-2 md:p-6 text-lg text-gray-800">
        {!formIsShowing && (
          <div className="flex justify-center">
            <button
              className="py-2 px-4 rounded-3xl border border-black bg-admin-blue shadow-xl
          focus:ring-indigo-200 focus:ring-offset-0 focus:ring-3 focus:outline-none"
              onClick={() => setFormIsShowing(!formIsShowing)}
            >
              Report An Incident
            </button>
          </div>
        )}
        {formIsShowing && (
          <form method="POST" action={props.form_path} className="space-y-4">
            <h3 className="py-2 admin-blue font-bold tracking-wide text-center">
              Report an Incident
            </h3>
            <div>
              <label className="block">When did this occur?</label>
              <input
                className="mt-1 rounded-md"
                type="date"
                name="date"
                defaultValue={props.incident_report.occurred_at || ''}
              />
            </div>
            <div>
              <label className="block">At which hotel did this occur?</label>
              <select className="mt-1 rounded-md" name="hotel_id">
                {Object.entries(props.hotel_map).map(([id, name], idx) => {
                  return (
                    <option key={idx} value={id}>
                      {name}
                    </option>
                  )
                })}
              </select>
            </div>
            <div>
              {/* <p className="font-bold">Incident Description</p> */}
              <p>Please describe the incident in detail.</p>
              <textarea
                className="mt-1 w-full h-32 resize-none rounded-md"
                name="description"
              />
            </div>
            <div className="flex items-center py-1 px-2 border border-gray-100 bg-admin-orange rounded-md">
              <div className="p-2">
                <input
                  className="w-6 h-6 rounded admin-blue
                border-2 border-black focus:border-indigo-500
                focus:ring-indigo-200 focus:ring-offset-0 focus:ring-3"
                  type="checkbox"
                  name="red_flag"
                  defaultValue={props.incident_report.red_flag || ''}
                />
              </div>
              <p>
                Check this box if the hotel wants to ban this client after this
                incident.
              </p>
            </div>
            <div className="flex justify-center">
              <button
                className="my-4 py-2 px-4 rounded-3xl border border-black bg-admin-blue shadow-xl
              font-semibold tracking-wide focus:ring-indigo-200 focus:ring-offset-0 focus:ring-3 focus:outline-none"
                type="submit"
              >
                Submit Incident
              </button>
            </div>
          </form>
        )}
      </div>
    </div>
  )
}

export default Incidents
